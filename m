From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH-RESEND] vhost-vsock: fix orphan connection reset
Date: Thu, 08 Dec 2016 21:25:03 -0500 (EST)
Message-ID: <20161208.212503.1982293102523713728.davem__35159.7683191814$1481250311$gmane$org@davemloft.net>
References: <1481217046-7058-1-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481217046-7058-1-git-send-email-bergwolf@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: bergwolf@gmail.com
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Peng Tao <bergwolf@gmail.com>
Date: Fri,  9 Dec 2016 01:10:46 +0800

> local_addr.svm_cid is host cid. We should check guest cid instead,
> which is remote_addr.svm_cid. Otherwise we end up resetting all
> connections to all guests.
> 
> Cc: stable@vger.kernel.org [4.8+]
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peng Tao <bergwolf@gmail.com>

Applied and queued up for -stable, thanks.
