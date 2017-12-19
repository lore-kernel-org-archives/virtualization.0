From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Tue, 19 Dec 2017 13:20:17 -0500 (EST)
Message-ID: <20171219.132017.1652469595167726292.davem__27989.3871666447$1513707539$gmane$org@davemloft.net>
References: <1513644036-45230-1-git-send-email-sridhar.samudrala@intel.com>
	<20171219174259-mutt-send-email-mst@kernel.org>
	<ca709329-a47a-2e76-b1fc-38fc665d7c0b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ca709329-a47a-2e76-b1fc-38fc665d7c0b@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sridhar.samudrala@intel.com
Cc: mst@redhat.com, netdev@vger.kernel.org, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Date: Tue, 19 Dec 2017 09:41:39 -0800

> This is based on netvsc implementation and here is the commit that
> added this delay.=A0 Not sure if this needs to be 100ms.
> =

> commit 6123c66854c174e4982f98195100c1d990f9e5e6
> Author: stephen hemminger <stephen@networkplumber.org>
> Date:=A0=A0 Wed Aug 9 17:46:03 2017 -0700
> =

> =A0=A0=A0 netvsc: delay setup of VF device
> =

> =A0=A0=A0 When VF device is discovered, delay bring it automatically up in
> =A0=A0=A0 order to allow userspace to some simple changes (like renaming).

This is kind of bogus, I should have called this out when the patch
was posted.

Any delay is wrong, there needs to be tight synchronization if a
userspace operation must occur before proceeding.  If something
happens and userspace is delayed, this whole thing doesn't work.
