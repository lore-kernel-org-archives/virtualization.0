From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH net-next 2/3] virtio-net: use per-receive queue page
	frag alloc for mergeable bufs
Date: Thu, 26 Dec 2013 14:00:58 -0800
Message-ID: <1388095258.12212.37.camel__49717.8279482343$1388095274$gmane$org@edumazet-glaptop2.roam.corp.google.com>
References: <1387239389-13216-1-git-send-email-mwdalton@google.com>
	<1387239389-13216-2-git-send-email-mwdalton@google.com>
	<52B7F065.3010707@redhat.com>
	<1387819627.12212.4.camel@edumazet-glaptop2.roam.corp.google.com>
	<20131223193704.GC1582@redhat.com>
	<CANJ5vPLEV_Z-D-0tThwhWXbHVaRWOLv566Xk1eD4TNYqNvknHw@mail.gmail.com>
	<20131226213727.GA10259@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131226213727.GA10259@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michael Dalton <mwdalton@google.com>, netdev@vger.kernel.org, lf-virt <virtualization@lists.linux-foundation.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-12-26 at 23:37 +0200, Michael S. Tsirkin wrote:

> Interesting. But if we can't allocate a buffer how can we
> do network processing?

How typical NIC drivers handle this case ?

Answer : nothing special should happen, we drop incoming traffic,
and make sure the driver recovers properly. (like not NULL deref or
crazy things like that)

Why virtio_net should be different ?

> 
> If we can reproduce the problem, we can maybe move
> allocation out of napi disabled section, but then
> we'll need to add more locking.

More exactly, use appropriate locking ;)
