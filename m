From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PULL] lguest fix, virtio documentation
Date: Mon, 15 Aug 2011 17:48:32 +0300
Message-ID: <1313419712.3004.1.camel__3429.94764582745$1313419840$gmane$org@sasha>
References: <87sjp37au3.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87sjp37au3.fsf@rustcorp.com.au>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2011-08-15 at 10:25 +0930, Rusty Russell wrote:
> [ This adds a text copy of the virtio draft spec to the kernel source,
>   which should make it easier for people to find and read.  The master
>   is still the lyx document on my server, so I'll keep it in sync. ]
> 
> The following changes since commit 91d85ea6786107aa2837bef3e957165ad7c8b823:
> 
>   Merge branch 'hwmon-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging (2011-08-13 18:37:28 -0700)
> 
> are available in the git repository at:
> 
>   ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master
> 
> Rusty Russell (2):
>       virtio: Add text copy of spec to Documentation/virtual.

The "Device Status" paragraph says FAILED is 8, while it should be 0x80.

-- 

Sasha.
