From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_blk: fix endianess annotations
Date: Fri, 30 May 2008 13:18:23 +1000
Message-ID: <200805301318.23933.rusty__22262.9171018072$1212117646$gmane$org@rustcorp.com.au>
References: <200805291110.01588.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805291110.01588.borntraeger@de.ibm.com>
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

On Thursday 29 May 2008 19:10:01 Christian Borntraeger wrote:
> Since commit 72e61eb40b55dd57031ec5971e810649f82b0259 (virtio: change
> config to guest endian) config space is no longer fixed endian.
>
> Lets change the virtio_blk_config variables.

Applied, thanks,
Rusty.
