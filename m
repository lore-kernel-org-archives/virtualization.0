From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: don't reserve space for vnet
 header for XDP
Date: Fri, 8 May 2020 09:59:29 +0800
Message-ID: <e1b67a0a-8499-39f9-0132-2ea62205289e@redhat.com>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506102123.739f1233@carbon>
 <3ecb558b-5281-2497-db3c-6aae7d7f882b@redhat.com>
 <20200506054619-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200506054619-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Jubran, Samih" <sameehj@amazon.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/6 下午5:46, Michael S. Tsirkin wrote:
>>> There
>>> are a lot of unanswered questions on how this will be implemented.
>>> Thus, I cannot layout how we are going to leverage this info yet, but
>>> your patch are killing this info, which IHMO is going in the wrong
>>> direction.
>> I can copy vnet header ahead of data_hard_start, does it work for you?
>>
>> Thanks
> That's likely to be somewhat expensive.


Any better approach? Note that it's not the issue that is introduced in 
this patch. Anyhow the header adjustment may just overwrite the vnet 
header even without this patch.

Thanks
