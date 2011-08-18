From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH] virtio-blk: Add stats VQ to collect information about
	devices
Date: Thu, 18 Aug 2011 07:38:03 +0300
Message-ID: <1313642283.22532.4.camel__29587.2318595231$1313642408$gmane$org@lappy>
References: <1313524071-27250-1-git-send-email-levinsasha928@gmail.com>
	<4E4C481A.5080205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4E4C481A.5080205@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2011-08-17 at 16:00 -0700, Avi Kivity wrote:
> On 08/16/2011 12:47 PM, Sasha Levin wrote:
> > This patch adds support for an optional stats vq that works similary to the
> > stats vq provided by virtio-balloon.
> >
> > The purpose of this change is to allow collection of statistics about working
> > virtio-blk devices to easily analyze performance without having to tap into
> > the guest.
> >
> >
> 
> Why can't you get the same info from the host?  i.e. read sectors?

Some of the stats you can collect from the host, but some you can't.

The ones you can't include all the timing statistics and the internal
queue statistics (read/write merges).

The idea behind providing all of the stats on the stats vq (which is
basically what you see in '/dev/block/[device]/stats') is to give a
consistent snapshot of the state of the device.

> 
> Patches to virtio drivers should be preceded by specification updates so 
> that guest driver authors and alternative userspace developers have a 
> solid reference.
> 

I'll send an additional update to the spec.

-- 

Sasha.
