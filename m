From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 0/3] fix stuck in accessing hwrng attributes
Date: Wed, 17 Sep 2014 17:30:04 +0800
Message-ID: <20140917093004.GB1213@gondor.apana.org.au>
References: <1410796949-2221-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1410796949-2221-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: m@bues.ch, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mb@bu3sch.de, mpm@selenic.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 16, 2014 at 12:02:26AM +0800, Amos Kong wrote:
> If we read hwrng by long-running dd process, it takes too much cpu
> time and almost hold the mutex lock. When we check hwrng attributes
> from sysfs by cat, it gets stuck in waiting the lock releaseing.
> The problem can only be reproduced with non-smp guest with slow backend.
> 
> This patchset resolves the issue by changing rng_dev_read() to always
> schedule 10 jiffies after release mutex lock, then cat process can
> have chance to get the lock and execute protected code without stuck.

Sorry I'm not going to accept your fix which simply papers over
the problem.

Please bite the bullet and convert this over to RCU.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
