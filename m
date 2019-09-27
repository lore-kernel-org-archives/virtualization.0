From: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
Subject: Re: [PATCH] vsock/virtio: add support for MSG_PEEK
Date: Fri, 27 Sep 2019 15:38:43 +0000
Message-ID: <20190927153843.GA15350__18587.5470096775$1569598748$gmane$org@scw-93ddc8.cloud.online.net>
References: <1569522214-28223-1-git-send-email-matiasevara@gmail.com>
	<f069a65d-33b9-1fa8-d26e-b76cc51fc7cb@gmail.com>
	<20190927085513.tdiofiisrpyehfe5@steredhat.homenet.telecomitalia.it>
	<a7a77f0b-a658-6e46-3381-3dfea55b14d1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a7a77f0b-a658-6e46-3381-3dfea55b14d1@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Dumazet <eric.dumazet@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 27, 2019 at 06:37:00AM -0700, Eric Dumazet wrote:
> 
> 
> On 9/27/19 1:55 AM, Stefano Garzarella wrote:
> 
> > Good catch!
> > 
> > Maybe we can solve in this way:
> > 
> > 	list_for_each_entry(pkt, &vvs->rx_queue, list) {
> > 		size_t off = pkt->off;
> > 
> > 		if (total == len)
> > 			break;
> > 
> > 		while (total < len && off < pkt->len) {
> > 			/* using 'off' instead of 'pkt->off' */
> > 			...
> > 
> > 			total += bytes;
> > 			off += bytes;
> > 		}
> > 	}
> > 
> > What do you think?
> >
> 
> Maybe, but I need to see a complete patch, evil is in the details :)
>

Thanks both for your comments, I will take them into account and submit
a second version. 

Matias
