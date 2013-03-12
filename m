From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] virtio-scsi: use pr_err() instead of printk()
Date: Tue, 12 Mar 2013 14:13:26 +1030
Message-ID: <871ublwae9.fsf@rustcorp.com.au>
References: <1362626968-16871-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<5139B402.2030106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5139B402.2030106@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il 07/03/2013 04:29, Wanlong Gao ha scritto:
>> Convert the virtio-scsi driver to use pr_err() instead of printk().
>> 
>> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, applied.

Cheers,
Rusty.
