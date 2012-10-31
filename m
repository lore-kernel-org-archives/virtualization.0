From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 14/16] virtio: Convert dev_printk(KERN_<LEVEL> to
	dev_<level>(
Date: Thu, 01 Nov 2012 10:24:03 +1030
Message-ID: <87ip9q5hb8.fsf@rustcorp.com.au>
References: <cover.1351411047.git.joe@perches.com>
	<a32fa314ea4f0318869f62d0942d3f1f936219d6.1351411048.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a32fa314ea4f0318869f62d0942d3f1f936219d6.1351411048.git.joe@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Joe Perches <joe@perches.com> writes:

> dev_<level> calls take less code than dev_printk(KERN_<LEVEL>
> and reducing object size is good.
> Convert if (printk_ratelimit()) dev_printk to dev_<level>_ratelimited.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.

Thanks,
Rusty.
