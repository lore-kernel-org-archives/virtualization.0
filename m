From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
Date: Mon, 6 Apr 2020 06:09:27 -0700
Message-ID: <20200406130927.GA20291@infradead.org>
References: <20200405081355.2870-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200405081355.2870-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Pleae just drop the code - we should not add new drivers with custom
DMA ops.
