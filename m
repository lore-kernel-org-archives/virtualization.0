From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH 1/3] virtio_console:Merge struct buffer_token into struct
	port_buffer
Date: Wed, 26 Sep 2012 18:40:35 +0900
Message-ID: <5062CD93.8090600@hitachi.com>
References: <1348580837-10919-1-git-send-email-sjur.brandeland@stericsson.com>
	<1348580837-10919-2-git-send-email-sjur.brandeland@stericsson.com>
	<50626C11.9040708@hitachi.com>
	<81C3A93C17462B4BBD7E272753C1057923BD8365F7@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057923BD8365F7@EXDCVYMBSTM005.EQ1STM.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Cc: "sjurbren@gmail.com" <sjurbren@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "yrl.pp-manager.tt@hitachi.com" <yrl.pp-manager.tt@hitachi.com>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

(2012/09/26 16:48), Sjur BRENDELAND wrote:
>>> -static struct port_buffer *alloc_buf(size_t buf_size)
>>> +static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
>>> +				     int nrbufs)
>>>  {
>>>  	struct port_buffer *buf;
>>> +	size_t alloc_size;
>>>
>>> -	buf = kmalloc(sizeof(*buf), GFP_KERNEL);
>>> +	/* Allocate buffer and the scatter list */
>>> +	alloc_size = sizeof(*buf) + sizeof(struct scatterlist) * nrbufs;
>>
>> This allocates one redundant sg entry when nrbuf > 0,
>> but I think it is OK. (just a comment)
> 
> I did this on purpose for the sake of simplicity, but I can
> change this to something like:
> 	 alloc_size = sizeof(*buf) + sizeof(buf->sg) * max(nrbufs - 1, 1);

You wouldn't need to change that. I think current code is enough simple
and reasonable. :)

Thanks!

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
