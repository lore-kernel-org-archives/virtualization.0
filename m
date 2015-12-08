From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/6] VSOCK: revert virtio-vsock until device spec is
	finalized
Date: Tue, 08 Dec 2015 11:26:55 -0500 (EST)
Message-ID: <20151208.112655.353902854757115664.davem__23974.3351740346$1449592031$gmane$org@davemloft.net>
References: <1449575856-28507-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449575856-28507-1-git-send-email-stefanha@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: stefanha@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mbenjamin@redhat.com, christoffer.dall@linaro.org, matt.ma@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  8 Dec 2015 19:57:30 +0800

> Please revert for now.

Please don't revert it piece by piece like this.

Instead, send me one big revert commit that undoes the whole
thing.  There is even a merge commit that you can use to
create that revert cleanly.

Thanks.
