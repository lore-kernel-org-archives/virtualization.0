From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_console: avoid config access from irq
Date: Wed, 04 Mar 2015 11:08:18 +1030
Message-ID: <87fv9lk35x.fsf__29877.5350711823$1425429783$gmane$org@rustcorp.com.au>
References: <1425145305-27917-1-git-send-email-mst@redhat.com>
	<20150302055625.GE26196@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150302055625.GE26196@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:
> On (Sat) 28 Feb 2015 [18:42:25], Michael S. Tsirkin wrote:
>> when multiport is off, virtio console invokes config access from irq
>> context, config access is blocking on s390.
>> Fix this up by scheduling work from config irq - similar to what we do
>> for multiport configs.
>> 
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> Reviewed-by: Amit Shah <amit.shah@redhat.com>

Applied, thanks.

Should these be CC: stable?

Cheers,
Rusty.
