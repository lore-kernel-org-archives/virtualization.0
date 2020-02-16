From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] virtio_balloon: Adjust label in virtballoon_probe
Date: Sun, 16 Feb 2020 00:47:35 -0700
Message-ID: <20200216074735.GA4717@ubuntu-m2-xlarge-x86>
References: <20200216004039.23464-1-natechancellor@gmail.com>
 <67FCAE69-05CF-4588-A7BC-664267D14BAF@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <67FCAE69-05CF-4588-A7BC-664267D14BAF@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Feb 16, 2020 at 08:36:45AM +0100, David Hildenbrand wrote:
> 
> 
> > Am 16.02.2020 um 01:41 schrieb Nathan Chancellor <natechancellor@gmail.com>:
> > 
> > ﻿Clang warns when CONFIG_BALLOON_COMPACTION is unset:
> > 
> > ../drivers/virtio/virtio_balloon.c:963:1: warning: unused label
> > 'out_del_vqs' [-Wunused-label]
> > out_del_vqs:
> > ^~~~~~~~~~~~
> > 1 warning generated.
> > 
> 
> Thanks, there is already „ [PATCH] virtio_balloon: Fix unused label warning“ from Boris on the list.
> 
> Cheers!
> 

Sorry for the noise, I thought I did a search for duplicate patches but
seems I missed it :/ I've commented on that patch.

Cheers,
Nathan
