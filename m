From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Wed, 4 Apr 2018 10:44:00 -0700
Message-ID: <20180404104400.28b81570__26941.430863417$1522863745$gmane$org@xeon-e3>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
	<1522573990-5242-3-git-send-email-si-wei.liu@oracle.com>
	<8b589cd2-1abc-59c2-99f1-96df8174bb6b@gmail.com>
	<20180403154210.GK3313@nanopsycho>
	<3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
	<CADGSJ22qmdzY8AiOfQdFdmR7T6rehTp-hHHj1U10XGad0bTb8A@mail.gmail.com>
	<b0f5e27b-0be1-311e-f3f3-f79af5cd4521@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b0f5e27b-0be1-311e-f3f3-f79af5cd4521@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Ahern <dsahern@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Netdev <netdev@vger.kernel.org>, Si-Wei Liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 4 Apr 2018 11:37:52 -0600
David Ahern <dsahern@gmail.com> wrote:

> Networking vendors have out of tree kernel modules. Those modules use a
> netdev (call it a master netdev, a control netdev, cpu port, whatever)
> to pull packets from the ASIC and deliver to virtual netdevices
> representing physical ports. The master netdev should not be mucked with
> by a user. It should be ignored by certain s/w with lldpd as just an
> *example*.

Sorry, the linux kernel maintainers have a clear well defined attitude
about out of tree kernel modules...
