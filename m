From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Wed, 06 Jun 2007 16:41:30 -0700
Message-ID: <4667462A.2010404@zytor.com>
References: <20070606225837.654272428@goop.org>
	<20070606230922.476662240@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070606230922.476662240@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> This patch makes the payload of the bzImage file an ELF file.  In
> other words, the bzImage is structured as follows:
>  - boot sector
>  - 16bit setup code
>  - ELF header
>   - decompressor
>   - compressed kernel
> 
> A bootloader may find the start of the ELF file by looking at the
> setup_size entry in the boot params, and using that to find the offset
> of the ELF header.  The ELF Phdrs contain all the mapped memory
> required to decompress and start booting the kernel.
> 
> One slightly complex part of this is that the bzImage boot_params need
> to know about the internal structure of the ELF file, at least to the
> extent of being able to point the core32_start entry at the ELF file's
> entrypoint, so that loaders which use this field will still work.
> 
> Similarly, the ELF header needs to know how big the kernel vmlinux's
> bss segment is, in order to make sure is is mapped properly.
> 
> To handle these two cases, we generate abstracted versions of the
> object files which only contain the symbols we care about (generated
> with objcopy --strip-all --keep-symbol=X), and then include those
> symbol tables with ld -R.

I still believe that we should provide, in effect, vmlinux as a
(compressed) ELF file rather than provide the intermediate stage.  It
would reduce the complexity of testing (all information provided about a
stage have to be both guaranteed to even make sense in the future as
well as be tested to conform to such information) as well as cover a
larger number of environments -- any environment where injecting data
into memory is cheaper than execution is quite unhappy about the current
system.  Such environments include heterogeneous embedded systems (think
a slow CPU on a PCI card where the host CPU has direct access to the
memory on the card) as well as simulators/emulators.

For environments where so is appropriate it would even be possible to
run the setup, invoke the code32_setup hook to do the decompression (and
relocation, if appropriate) in host space.

This makes vmlinux (normally stripped) recoverable from the bzImage file
and so anything that is currently booting vmlinux would be serviced by
this scheme.

	-hpa
