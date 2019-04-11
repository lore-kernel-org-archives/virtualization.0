From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost: reject zero size iova range
Date: Wed, 10 Apr 2019 22:46:28 -0700 (PDT)
Message-ID: <20190410.224628.1651735622261723310.davem__28840.7899484568$1554961632$gmane$org@davemloft.net>
References: <20190409041025.20922-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190409041025.20922-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue,  9 Apr 2019 12:10:25 +0800

> We used to accept zero size iova range which will lead a infinite loop
> in translate_desc(). Fixing this by failing the request in this case.
> 
> Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com
> Fixes: 6b1e6cc7 ("vhost: new device IOTLB API")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.
