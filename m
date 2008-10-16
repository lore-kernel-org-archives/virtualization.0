From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] virtio_net: Recycle some more rx buffer pages
Date: Thu, 16 Oct 2008 16:08:53 +1100
Message-ID: <200810161608.54017.rusty@rustcorp.com.au>
References: <> <1223494499-18732-1-git-send-email-markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753102AbYJPFLT@vger.kernel.org>
In-Reply-To: <1223494499-18732-1-git-send-email-markmc@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 09 October 2008 06:34:58 Mark McLoughlin wrote:
> Each time we re-fill the recv queue with buffers, we allocate
> one too many skbs and free it again when adding fails. We should
> recycle the pages allocated in this case.
>
> A previous version of this patch made trim_pages() trim trailing
> unused pages from skbs with some paged data, but this actually
> caused a barely measurable slowdown.

Yes, I noticed a similar effect.  Not quite sure why though.

Applied.

Thanks!
Rusty.
