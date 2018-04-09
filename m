From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: kernel BUG at drivers/vhost/vhost.c:LINE! (2)
Date: Mon, 9 Apr 2018 05:44:36 +0300
Message-ID: <20180409054316-mutt-send-email-mst__24817.0163635679$1523241768$gmane$org@kernel.org>
References: <001a11449424f11322056932b09c@google.com>
	<CAJSP0QVHk7NSQcjfLWq13=1Vzm=_vtmKZqp4dDjuh8ETLO5g_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJSP0QVHk7NSQcjfLWq13=1Vzm=_vtmKZqp4dDjuh8ETLO5g_g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm <kvm@vger.kernel.org>, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, syzbot <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 09, 2018 at 10:37:45AM +0800, Stefan Hajnoczi wrote:
> On Sat, Apr 7, 2018 at 3:02 AM, syzbot
> <syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com> wrote:
> > syzbot hit the following crash on upstream commit
> > 38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +0000)
> > Merge tag 'armsoc-drivers' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> > syzbot dashboard link:
> > https://syzkaller.appspot.com/bug?extid=65a84dde0214b0387ccd
> 
> To prevent duplicated work: I am working on this one.
> 
> Stefan

Do you want to try this patchset:
https://lkml.org/lkml/2018/4/5/665

?

-- 
MST
