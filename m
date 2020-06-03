From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 04/13] vhost: cleanup fetch_buf return code handling
Date: Wed, 3 Jun 2020 15:29:02 +0800
Message-ID: <7221afa5-bafd-f19b-9cfd-cc51a8d3b321@redhat.com>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-5-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200602130543.578420-5-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/2 下午9:06, Michael S. Tsirkin wrote:
> Return code of fetch_buf is confusing, so callers resort to
> tricks to get to sane values. Let's switch to something standard:
> 0 empty, >0 non-empty, <0 error.
>
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> ---
>   drivers/vhost/vhost.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)


Why not squashing this into patch 2 or 3?

Thanks
