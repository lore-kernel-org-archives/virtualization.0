From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Thu, 21 Mar 2013 20:01:26 +0200
Message-ID: <20130321180126.GA4366@redhat.com>
References: <514B2FA0.9000204@zytor.com> <20130321161143.GC1925@redhat.com>
	<514B3213.8070002@zytor.com> <20130321162636.GF1925@redhat.com>
	<514B3606.2090503@zytor.com> <20130321170706.GB2994@redhat.com>
	<514B3EAE.8000707@zytor.com> <20130321171319.GD2994@redhat.com>
	<20130321174912.GA4161@redhat.com> <514B4957.1070003@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <514B4957.1070003@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 10:54:31AM -0700, H. Peter Anvin wrote:
> On 03/21/2013 10:49 AM, Michael S. Tsirkin wrote:
> > 
> > Just to clarify, I expect BIOS to use it *for config access*.
> > Notification will support IO anyway because it's
> > faster on KVM, so BIOS can use it directly.
> > 
> 
> Ah, yes, of course.
> 
> Quite frankly, I don't see any reason to support *anything else* for
> configuration, does anyone else?
> 
> I thought we were talking about the doorbell/notification/kicker
> register.  For I/O space especially it is highly desirable if that can
> be in a minimal BAR (4 bytes).
> 
> 	-hpa


Not necessarily a BAR. We have trouble allocating IO BARs.  What I want
to allow is hypervisor which allocates a fixed address/data pair
in the hypervisor, reserves it in ACPI and reports to driver through a
vendor specific capability.

You likely didn't see this discussion, it was only sent to kvm
and virtualization lists, the subject is
'virtio PCI on KVM without IO BARs'


-- 
MST
