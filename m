From: Juan Quintela <quintela@redhat.com>
Subject: Re: [PULL] virtio console fixes, abi change
Date: Wed, 14 Apr 2010 09:25:36 +0200
Message-ID: <m3633ulclr.fsf@trasno.mitica>
References: <20100414053557.GA4442@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100414053557.GA4442@amit-x200.redhat.com> (Amit Shah's message
	of "Wed, 14 Apr 2010 11:05:57 +0530")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> wrote:
> Hello Rusty,
>
> To avoid sending the same patches again, this time I'm trying a git pull
> request.
>
> Please pull from
>
> git://git.kernel.org/pub/scm/linux/kernel/git/amit/vs-kernel.git for-rusty
>
> to get the patches that I've sent to the list previously, with a couple
> of fixes:
>
> - Create a console port when not using multiport (fix was sent as a
>   reply to prev. series)
>
> - Add hunk that got inadvertently reverted during git rebase operations
>   (thanks Juan).
>
> The diff to the v6 version is attached below:

Acked-by: Juan Quintela <quintela@redhat.com>
