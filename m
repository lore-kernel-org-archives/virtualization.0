From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC PATCH] virtio: change config to guest endian.
Date: Tue, 22 Apr 2008 14:22:48 +0300
Message-ID: <480DCA88.4010407__5256.18372853405$1208863619$gmane$org@qumranet.com>
References: <200804221357.34571.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804221357.34571.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Hollis Blanchard <hollisb@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> [Christian, Hollis, how much is this ABI breakage going to hurt you?]
>
> A recent proposed feature addition to the virtio block driver revealed
> some flaws in the API, in particular how easy it is to break big
> endian machines.
>
> The virtio config space was originally chosen to be little-endian,
> because we thought the config might be part of the PCI config space
> for virtio_pci.  It's actually a separate mmio region, so that
> argument holds little water; as only x86 is currently using the virtio
> mechanism, we can change this (but must do so now, before the
> impending s390 and ppc merges).
>
>   

This will probably annoy Hollis which has guests that can go both ways.

-- 
error compiling committee.c: too many arguments to function
