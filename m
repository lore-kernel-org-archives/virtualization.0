From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 04/13] vhost: cleanup fetch_buf return code handling
Date: Thu, 4 Jun 2020 05:01:12 -0400
Message-ID: <20200604050011-mutt-send-email-mst@kernel.org>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-5-mst@redhat.com>
 <7221afa5-bafd-f19b-9cfd-cc51a8d3b321@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7221afa5-bafd-f19b-9cfd-cc51a8d3b321@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 03, 2020 at 03:29:02PM +0800, Jason Wang wrote:
> 
> On 2020/6/2 下午9:06, Michael S. Tsirkin wrote:
> > Return code of fetch_buf is confusing, so callers resort to
> > tricks to get to sane values. Let's switch to something standard:
> > 0 empty, >0 non-empty, <0 error.
> > 
> > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > ---
> >   drivers/vhost/vhost.c | 24 ++++++++++++++++--------
> >   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> 
> Why not squashing this into patch 2 or 3?
> 
> Thanks

It makes the tricky patches smaller. I'll consider it,
for now this split is also because patches 1-3 have
already been tested.

-- 
MST
