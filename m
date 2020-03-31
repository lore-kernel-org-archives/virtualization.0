From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vhost: make CONFIG_VHOST depend on CONFIG_EVENTFD
Date: Mon, 30 Mar 2020 19:52:48 -0700
Message-ID: <5646e48a-b1af-6253-bc17-667ab9419fd3@infradead.org>
References: <20200331022902.12229-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200331022902.12229-1-jasowang@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 3/30/20 7:29 PM, Jason Wang wrote:
> After commit ec9d8449a99b ("vhost: refine vhost and vringh kconfig"),
> CONFIG_VHOST could be enabled independently. This means we need make
> CONFIG_VHOST depend on CONFIG_EVENTFD, otherwise we break compiling
> without CONFIG_EVENTFD.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: ec9d8449a99b ("vhost: refine vhost and vringh kconfig")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.

-- 
~Randy
