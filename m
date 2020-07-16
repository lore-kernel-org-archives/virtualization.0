From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] vsock/virtio: annotate 'the_virtio_vsock' RCU pointer
Date: Wed, 15 Jul 2020 17:49:51 -0700
Message-ID: <20200715174951.0c4e5bca@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200710121243.120096-1-sgarzare@redhat.com>
        <20200713065423-mutt-send-email-mst@kernel.org>
        <20200715143446.kfl3zb4vwkk4ic4r@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200715143446.kfl3zb4vwkk4ic4r@steredhat>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, davem@davemloft.net, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 15 Jul 2020 16:34:46 +0200 Stefano Garzarella wrote:
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > who's merging this? Dave?  
> 
> I think so, but I forgot the 'net' tag :-(
> 
> I'll wait to see if Dave will queue this, otherwise I'll resend with
> the 'net' tag.

Applied to net now, thanks!
