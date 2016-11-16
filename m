From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Wed, 16 Nov 2016 07:10:36 -0500 (EST)
Message-ID: <1627682877.13077005.1479298236793.JavaMail.zimbra@redhat.com>
References: <20160820080744.10344-1-namhyung@kernel.org>
	<20161110182611-mutt-send-email-mst@kernel.org>
	<20161115045021.GA15992@danjae.aot.lge.com>
	<20161115065658-mutt-send-email-mst@kernel.org>
	<f514ac65-3105-a12c-9e10-2d3b1e8a0516@redhat.com>
	<20161115143629.GA29740@danjae.aot.lge.com>
	<a6fc0acb-6ecc-a184-9e06-e76c7398fc08@redhat.com>
	<CAM9d7cj8CxS77WC-7O7fRX1s0sqTZqJo=ZHseN-hc2jpE8QD2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAM9d7cj8CxS77WC-7O7fRX1s0sqTZqJo=ZHseN-hc2jpE8QD2Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, KVM <kvm@vger.kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel <qemu-devel@nongnu.org>, Minchan Kim <minchan@kernel.org>, Anton Vorontsov <anton@enomsg.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

> Not sure how independent ERST is from ACPI and other specs.  It looks
> like referencing UEFI spec at least.

It is just the format of error records that comes from the UEFI spec
(include/linux/cper.h) but you can ignore it, I think.  It should be
handled by tools on the host side.  For you, the error log address
range contains a CPER header followed by a binary blob.  In practice,
you only need the record length field (bytes 20-23 of the header),
though it may be a good idea to validate the signature at the beginning
of the header.

> Btw, is the ERST used for pstore only (in Linux)?

Yes.  It can store various records, including dmesg and MCE.

There are other examples in QEMU of interfaces with ACPI.  They all use the
DSDT, but the logic is similar.  For example, docs/specs/acpi_mem_hotplug.txt
documents the memory hotplug interface. In all cases, ACPI tables contain small
programs that talk to specialized hardware registers, typically allocated to
hard-coded I/O ports.

In your case, the registers could occupy 16 consecutive I/O ports, like the
following:

     0x00       read/write   operation type (0=write,1=read,2=clear,3=dummy write)

     0x01       read-only    bit 7: if set, operation in progress

                             bit 0-6: operation status, see "Command Status Definition" in
                             the ACPI spec

     0x02       read-only    when read:

                             - read a 64-bit record id from the store to memory,
                               from the address that was last written to 0x08.

                             - if the id is valid and is not the last id in the store,
                               write the next 64-bit record id to the same address

                             - otherwise, write the first record id to the same address,
                               or 0xffffffffffffffff if the store is empty

     0x03                    unused, read as zero

     0x04-0x07  read/write   offset of the error record into the error log address range

     0x08-0x0b  read/write   when read, return number of stored records

                             when written, the written value is a 32-bit memory address,
                             which points to a 64-bit location used to communicate record ids.

     0x0c-0x0f  read/write   when read, always return -1 (together with the "mask" field
                             and READ_REGISTER, this lets ERST instructions return any value!)

                             when written, trigger the pstore operation:

                             - if the current operation is a dummy write, do nothing

                             - if the current operation is a write, write a new record, using
                             the written value as the base of the error log address range.  The
                             length must be parsed from the CPER header.

                             - if the current operation is a clear, read the record id
                             from the memory location that was last written to 0x08 and do the
                             operation.  the value written is ignored.

                             - if the current operation is a read, read the record id from the
                             memory location that was last written to 0x08, using the written
                             value as the base of the error log address range.

In addition, the firmware will need to reserve a few KB of RAM for the error log
address range (I checked a real system and it reserves 8KB).  The first eight
bytes are needed for the record identifier interface, because there's no such
thing as 64-bit I/O ports, and the rest can be used for the actual buffer.

QEMU already has an interface to allocate RAM and patch the address into an
ACPI table (bios_linker_loader_alloc).  Because this interface is actually meant
to load data from QEMU into the firmware (using the "fw_cfg" interface), you
would have to add a dummy 8KB file to fw_cfg using fw_cfg_add_file (for
example "etc/erst-memory"), it can be just full of zeros.

QEMU supports two chipsets, PIIX and ICH9, and the free I/O port ranges are
different.  You could use 0xa20 for ICH9 and 0xae20 for PIIX.

All in all, the contents of the ERST table would not be very different from a
non-virtual system, except that on real hardware the firmware would use SMIs
as the trap mechanism.  You almost have a one-to-one mapping between ERST
actions and registers accesses:

   BEGIN_WRITE_OPERATION                  write value 0 to register at 0x00
   BEGIN_READ_OPERATION                   write value 1 to register at 0x00
   BEGIN_CLEAR_OPERATION                  write value 2 to register at 0x00
   BEGIN_DUMMY_WRITE_OPERATION            write value 3 to register at 0x00
   END_OPERATION                          no-op
   CHECK_BUSY_STATUS                      read register at 0x01 with mask 0x80
   GET_COMMAND_STATUS                     read register at 0x01 with mask 0x7f
   SET_RECORD_OFFSET                      write register at 0x04
   GET_RECORD_COUNT                       read register at 0x08
   EXECUTE_OPERATION                      write ERST memory base + 8 to 0x0c
   GET_ERROR_LOG_ADDRESS_RANGE            read register at 0x0c (with mask = ERST memory base + 8)
   GET_ERROR_LOG_ADDRESS_RANGE_LENGTH     read register at 0x0c (with mask = 8192 - 8 = 8184)
   GET_ERROR_LOG_ADDRESS_RANGE_ATTRIBUTES read register at 0x0c (with mask = 0)

Only the get/set record identifier instructions are a little harder:

   GET_RECORD_IDENTIFIER                  write ERST memory base to register at 0x08
                                          read register at 0x02
                                          read eight bytes at ERST memory base

   SET_RECORD_IDENTIFIER                  write ERST memory base to register at 0x08
                                          write eight bytes at ERST memory base

On top of this, you need to add the APEI UUID (see apei_osc_setup in Linux)
to build_q35_osc_method, and use "-M q35" when you start QEMU.  If you need
more help just ask.  I or others can help you with the ACPI glue, then you
can write the file backend yourself, based on your existing virtio-pstore code.

> Also I need to control pstore driver like using bigger buffer,
> enabling specific message types and so on if ERST supports.  Is it
> possible for ERST to provide such information?

It's the normal pstore driver, same as on a real server.  What exactly do you
need?

Paolo
