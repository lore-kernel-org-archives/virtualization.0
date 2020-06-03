From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 02/13] vhost: use batched version by default
Date: Wed, 3 Jun 2020 15:15:54 +0800
Message-ID: <9dc9fb1b-c9d0-7c67-8297-f8a7dcc4c79e@redhat.com>
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-3-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200602130543.578420-3-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/2 下午9:05, Michael S. Tsirkin wrote:
> As testing shows no performance change, switch to that now.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> Link: https://lore.kernel.org/r/20200401183118.8334-3-eperezma@redhat.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/vhost/vhost.c | 251 +-----------------------------------------
>   drivers/vhost/vhost.h |   4 -
>   2 files changed, 2 insertions(+), 253 deletions(-)


Since we don't have a way to switch back, it's better to remove "by 
default" in the title.

Thanks
