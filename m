From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V2 0/4] Fix several issues of virtio-net mergeable XDP
Date: Wed, 23 May 2018 13:37:58 -0400 (EDT)
Message-ID: <20180523.133758.2273298453278600346.davem__49806.4355146655$1527096982$gmane$org@davemloft.net>
References: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 May 2018 11:44:27 +0800

> Please review the patches that tries to fix sevreal issues of
> virtio-net mergeable XDP.
> 
> Changes from V1:
> - check against 1 before decreasing instead of resetting to 1
> - typoe fixes

Series applied and queued up for -stable.
