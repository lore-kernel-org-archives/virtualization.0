From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio console: don't manually set or finalize
	VIRTIO_CONSOLE_F_MULTIPORT.
Date: Wed, 9 Mar 2011 12:43:07 +0530
Message-ID: <20110309071307.GC20531@amit-x200.redhat.com>
References: <87ei6hknod.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ei6hknod.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: alexey.kardashevskiy@au1.ibm.com, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 09 Mar 2011 [13:25:30], Rusty Russell wrote:
> That's already been done by the virtio infrastructure before the probe
> function is called.
> 
> Reported-by: alexey.kardashevskiy@au1.ibm.com
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Acked-by: Amit Shah <amit.shah@redhat.com>
Tested-by: Amit Shah <amit.shah@redhat.com>

		Amit
