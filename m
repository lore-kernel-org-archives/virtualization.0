From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC PATCH 0/4] Inter-guest virtio I/O example with
	lguest
Date: Thu, 20 Mar 2008 08:54:45 +0200
Message-ID: <47E20A35.2000600__7348.9767768935$1205996391$gmane$org@qumranet.com>
References: <200803201659.14344.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201659.14344.rusty@rustcorp.com.au>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Hi all,
>
>    Just finished my prototype of inter-guest virtio, using networking as an 
> example.  Each guest mmaps the other's address space and uses a FIFO for 
> notifications.
>
>   

Isn't that a security hole (hole? chasm)?  If the two guests can access 
each other's memory, they might as well be just one guest, and 
communicate internally.

My feeling is that the host needs to copy the data, using dma if 
available.  Another option is to have one guest map the other's memory 
for read and write, while the other guest is unprivileged.  This allows 
one privileged guest to provide services for other, unprivileged guests, 
like domain 0 or driver domains in Xen.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
