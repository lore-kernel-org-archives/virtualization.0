From: Andy King <acking@vmware.com>
Subject: RE: [Pv-drivers] vmci: read overrun bug in dg_dispatch_as_host()
	(drivers/misc/vmw_vmci/vmci_datagram.c)
Date: Thu, 19 Feb 2015 18:40:17 +0000
Message-ID: <0bb9cd747bf3454b89d82a332eb62d7c@EX13-MBX-018.vmware.com>
References: <79A62150-2711-45E2-A83E-313F5060C73F@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <79A62150-2711-45E2-A83E-313F5060C73F@stanford.edu>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Ramos <daramos@stanford.edu>, "VMware, Inc." <pv-drivers@vmware.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi David,

> This provides an upper bound of 69,632 bytes, but it doesn=92t relate the=
 payload size to
> the actual size of the user-supplied datagram. I think there should be a =
comparison
> with 'send_info.len=92 in vmci_host_do_send_datagram().

Thanks so much for finding this and bringing it to our attention! I've just=
 sent out
a patch in a separate email (cc'd you) that hopefully addresses this. If yo=
u find any
others, we would of course be happy to fix them. We do appreciate extra eye=
s.

Kind regards,
- Andy
