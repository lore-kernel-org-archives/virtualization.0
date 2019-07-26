From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: INFO: rcu detected stall in vhost_worker
Date: Fri, 26 Jul 2019 14:35:25 -0700
Message-ID: <CAHk-=whnM5+FBJuVoxXELvFgecuc0+vW7ibWy4Gc5qJbW8HL2Q__2116.41813382215$1564176955$gmane$org@mail.gmail.com>
References: <000000000000b4358f058e924c6d@google.com>
	<000000000000e87d14058e9728d7@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <000000000000e87d14058e9728d7@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: syzbot <syzbot+36e93b425cd6eb54fcc1@syzkaller.appspotmail.com>
Cc: michal.lkml@markovi.net, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Netdev <netdev@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 26, 2019 at 8:26 AM syzbot
<syzbot+36e93b425cd6eb54fcc1@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 0ecfebd2b52404ae0c54a878c872bb93363ada36
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Jul 7 22:41:56 2019 +0000
>
>      Linux 5.2

That seems very unlikely. That commit literally just changes the
EXTRAVERSION part of the version string.

So even if something actually depended on the version number, even
that wouldn't have triggered any semantic change.

              Linus
