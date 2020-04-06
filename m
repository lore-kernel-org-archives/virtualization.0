From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
Date: Mon, 6 Apr 2020 10:02:53 -0400
Message-ID: <20200406095931-mutt-send-email-mst@kernel.org>
References: <20200405081355.2870-1-mst@redhat.com>
 <20200406130927.GA20291@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200406130927.GA20291@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 06, 2020 at 06:09:27AM -0700, Christoph Hellwig wrote:
> Pleae just drop the code - we should not add new drivers with custom
> DMA ops.

I'm not sure there's another way to do this: this not a driver, it's a
software emulator that pretends to be an actual device. We can't
have the platform supply DMA ops here since the platform is a regular
x86 or whatever.

-- 
MST
