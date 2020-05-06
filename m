From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: performance bug in virtio net xdp
Date: Wed, 6 May 2020 07:57:41 -0400
Message-ID: <20200506075719-mutt-send-email-mst@kernel.org>
References: <20200506035704-mutt-send-email-mst@kernel.org>
 <7d801479-5572-0031-b306-a735ca4ce0e4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7d801479-5572-0031-b306-a735ca4ce0e4@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 06, 2020 at 04:37:41PM +0800, Jason Wang wrote:
> 
> On 2020/5/6 下午4:08, Michael S. Tsirkin wrote:
> > So for mergeable bufs, we use ewma machinery to guess the correct buffer
> > size. If we don't guess correctly, XDP has to do aggressive copies.
> > 
> > Problem is, xdp paths do not update the ewma at all, except
> > sometimes with XDP_PASS. So whatever we happen to have
> > before we attach XDP, will mostly stay around.
> 
> 
> It looks ok to me since we always use PAGE_SIZE when XDP is enabled in
> get_mergeable_buf_len()?
> 
> Thanks
> 

Oh right. Good point! Answered in another thread.

> > 
> > The fix is probably to update ewma unconditionally.
> > 
