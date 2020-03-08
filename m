From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] drivers: virtio: Make out_del_vqs dependent on
 BALLOON_COMPACTION
Date: Sun, 8 Mar 2020 16:59:19 -0400
Message-ID: <20200308165831-mutt-send-email-mst@kernel.org>
References: <20200306105528.5272-1-vincenzo.frascino@arm.com>
 <4AB99BBC-0EC7-40F0-96ED-04796A73CBA2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4AB99BBC-0EC7-40F0-96ED-04796A73CBA2@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 08, 2020 at 08:38:19PM +0100, David Hildenbrand wrote:
> 
> 
> > Am 06.03.2020 um 11:56 schrieb Vincenzo Frascino <vincenzo.frascino@arm.com>:
> > 
> > ﻿out_del_vqs label is currently used only when BALLOON_COMPACTION
> > configuration option is enabled. Having it disabled triggers the
> > following warning at compile time:
> > 
> > drivers/virtio/virtio_balloon.c: In function ‘virtballoon_probe’:
> > drivers/virtio/virtio_balloon.c:963:1: warning: label ‘out_del_vqs’
> > defined but not used [-Wunused-label]
> >  963 | out_del_vqs:
> >      | ^~~~~~~~~~~
> > 
> > Make out_del_vqs dependent on BALLOON_COMPACTION to address the
> > issue.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> I think this is now the third patch on the list that tries to fix this warning.
> 
> Michael, can we finally queue one of these (or is there one in -next already - did not check)?
> 
> Thanks

It's queued in my tree (and will be in next eventually), I just didn't
send it to Linus yet.
Sorry about the delay.

-- 
MST
