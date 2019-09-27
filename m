From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] vsock/virtio: add support for MSG_PEEK
Date: Fri, 27 Sep 2019 06:37:00 -0700
Message-ID: <a7a77f0b-a658-6e46-3381-3dfea55b14d1__395.448196080395$1569591435$gmane$org@gmail.com>
References: <1569522214-28223-1-git-send-email-matiasevara@gmail.com>
	<f069a65d-33b9-1fa8-d26e-b76cc51fc7cb@gmail.com>
	<20190927085513.tdiofiisrpyehfe5@steredhat.homenet.telecomitalia.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927085513.tdiofiisrpyehfe5@steredhat.homenet.telecomitalia.it>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>, Eric Dumazet <eric.dumazet@gmail.com>, Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org



On 9/27/19 1:55 AM, Stefano Garzarella wrote:

> Good catch!
> 
> Maybe we can solve in this way:
> 
> 	list_for_each_entry(pkt, &vvs->rx_queue, list) {
> 		size_t off = pkt->off;
> 
> 		if (total == len)
> 			break;
> 
> 		while (total < len && off < pkt->len) {
> 			/* using 'off' instead of 'pkt->off' */
> 			...
> 
> 			total += bytes;
> 			off += bytes;
> 		}
> 	}
> 
> What do you think?
>

Maybe, but I need to see a complete patch, evil is in the details :)
