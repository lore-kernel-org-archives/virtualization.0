From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [v2 1/2] crypto: virtio: Fix src/dst scatterlist calculation in
 __virtio_crypto_skcipher_do_req()
Date: Tue, 26 May 2020 10:25:28 +0200
Message-ID: <b863c03b-18f3-4942-10fd-563ab4cf5b43@web.de>
References: <20200526031956.1897-1-longpeng2@huawei.com>
 <20200526031956.1897-2-longpeng2@huawei.com>
 <d58a046a-e559-55be-16ba-64db43a06568@web.de>
 <e1864c6d-6380-831f-9c2f-85611a78779b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e1864c6d-6380-831f-9c2f-85611a78779b@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: "Longpeng (Mike)" <longpeng2@huawei.com>, linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Corentin Labbe <clabbe@baylibre.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Gonglei <arei.gonglei@huawei.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

>> I suggest to move the addition of such input parameter validation
>> to a separate update step.
>>
> Um...The 'src_nents' will be used as a loop condition,
> so validate it here is needed ?

Would you prefer to add such checking as the first update in
another small patch series?

Regards,
Markus
