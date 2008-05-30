From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_config: fix len calculation of config elements
Date: Fri, 30 May 2008 13:18:04 +1000
Message-ID: <200805301318.05287.rusty__21401.2564080351$1212117618$gmane$org@rustcorp.com.au>
References: <200805271105.00077.borntraeger@de.ibm.com>
	<20080529083004.GQ25504@kernel.dk>
	<200805291108.01604.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805291108.01604.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 29 May 2008 19:08:01 Christian Borntraeger wrote:
> v is a pointer, to we have to use sizeof(*v) instead of sizeof(v).

How embarassing.  Applied, thanks.

Rusty.
