From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3] virtio-mmio: Fix irq parsing in command line parameter
Date: Fri, 09 Nov 2012 14:41:23 +1030
Message-ID: <87bof72z6c.fsf@rustcorp.com.au>
References: <878vad3u9r.fsf@rustcorp.com.au>
	<1352401544-8218-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1352401544-8218-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Pawel Moll <pawel.moll@arm.com> writes:
> When the resource_size_t is 64-bit long, the sscanf() on
> the virtio device command line paramter string may return
> wrong value because its format was defined as "%u". Fixed
> by using an intermediate local value of a known length.
>
> Also added cleaned up the resource creation and added extra
> comments to make the parameters parsing easier to follow.

Applied.

Thanks,
Rusty.
