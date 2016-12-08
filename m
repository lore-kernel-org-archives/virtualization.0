From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] vhost: remove unnecessary smp_mb from vhost_work_queue
Date: Thu, 08 Dec 2016 11:30:46 -0500 (EST)
Message-ID: <20161208.113046.64351554585995048.davem__46506.0345283293$1481214682$gmane$org@davemloft.net>
References: <1481104340-77035-1-git-send-email-bergwolf@gmail.com>
	<1481104340-77035-2-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481104340-77035-2-git-send-email-bergwolf@gmail.com>
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
Date: Wed,  7 Dec 2016 17:52:19 +0800

> test_and_set_bit() already implies a memory barrier.
> 
> Signed-off-by: Peng Tao <bergwolf@gmail.com>

Applied.
