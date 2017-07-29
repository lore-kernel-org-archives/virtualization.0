From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V2 net] Revert "vhost: cache used event for better
	performance"
Date: Sat, 29 Jul 2017 14:16:13 -0700 (PDT)
Message-ID: <20170729.141613.128128727353289484.davem__27825.5583289594$1501362981$gmane$org@davemloft.net>
References: <1501125725-24529-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1501125725-24529-1-git-send-email-jasowang@redhat.com>
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
Date: Thu, 27 Jul 2017 11:22:05 +0800

> This reverts commit 809ecb9bca6a9424ccd392d67e368160f8b76c92. Since it
> was reported to break vhost_net. We want to cache used event and use
> it to check for notification. The assumption was that guest won't move
> the event idx back, but this could happen in fact when 16 bit index
> wraps around after 64K entries.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied, thanks.
