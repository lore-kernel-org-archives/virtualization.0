From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH 4/9] virtio-serial: Handle
	scatter-gather buffers for control messages
Date: Mon, 22 Mar 2010 10:48:02 +0530
Message-ID: <20100322051802.GE24577@amit-x200.redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-2-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-3-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-4-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-5-git-send-email-amit.shah@redhat.com>
	<4BA47C02.3000105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BA47C02.3000105@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On (Sat) Mar 20 2010 [09:40:50], Avi Kivity wrote:
> On 03/19/2010 01:58 PM, Amit Shah wrote:
>> +
>> +        offset = 0;
>> +        for (i = 0; i<  elem.out_num; i++) {
>> +            memcpy(buf + offset, elem.out_sg[i].iov_base,
>> +                   elem.out_sg[i].iov_len);
>> +            offset += elem.out_sg[i].iov_len;
>> +        }
>> +        len = cur_len;
>> +
>> +        handle_control_message(vser, buf, len);
>> +        virtqueue_push(vq,&elem, len);
>> +    }
>> +    if (len) {
>> +        qemu_free(buf);
>>       }
>>       virtio_notify(vdev, vq);
>>   }
>
> Isn't there some virtio function to linearize requests?

I don't see one.

		Amit
