From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/7] blkio-cgroup: The body of blkio-cgroup
Date: Mon, 4 May 2009 13:39:42 +0100
Message-ID: <20090504133942.35dbe7cc__46210.0142766305$1241451349$gmane$org@lxorguk.ukuu.org.uk>
References: <20090428.214423.193684619.ryov@valinux.co.jp>
	<20090428.214457.226801820.ryov@valinux.co.jp>
	<20090428.214535.71090234.ryov@valinux.co.jp>
	<20090428.214604.104034341.ryov@valinux.co.jp>
	<20090504120544.GA3986@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090504120544.GA3986@linux>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrea Righi <righi.andrea@gmail.com>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

> few minor coding style issues reported by checkpatch.pl:

checkpatch is a *guide* not some dictator of style. If it's more readable
the way it is, or it's following existing style (eg with the export
symbols in a group at the bottom) then checkpatch is best ignored.
