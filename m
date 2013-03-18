From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv3 vringh] caif_virtio: Introduce caif over virtio
Date: Mon, 18 Mar 2013 14:08:58 +1030
Message-ID: <87li9ls7fx.fsf__9888.87634962357$1363594725$gmane$org@rustcorp.com.au>
References: <1363340537-16011-1-git-send-email-erwan.yvin@stericsson.com>
	<20130317.121436.461735238002154159.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130317.121436.461735238002154159.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>, erwan.yvin@stericsson.com
Cc: linus.walleij@stericsson.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, rusty@ruscorp.com.au, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

David Miller <davem@davemloft.net> writes:

> From: Erwan Yvin <erwan.yvin@stericsson.com>
> Date: Fri, 15 Mar 2013 10:42:17 +0100
>
>> caif-virtio is going to replace caif-shm.
>> This patch should be merged in rusty's tree. (vringh)
>> because there is a dependency with vringh wrapper.
>
> Feel free to add my:
>
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks, applied to my vringh branch.  I'll repost it all, to give you
and Sjur a chance to make sure I've integrated correctly.

Thanks,
Rusty.
