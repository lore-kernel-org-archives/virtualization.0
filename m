From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Potential hang in virtnet_send_command
Date: Mon, 18 Apr 2016 20:24:56 +0300
Message-ID: <20160418202315-mutt-send-email-mst@redhat.com>
References: <CAATJJ0JF7-ApjMO+XtsVgD8rU6WTCK28vTjmG-Aww-ASHw4cBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAATJJ0JF7-ApjMO+XtsVgD8rU6WTCK28vTjmG-Aww-ASHw4cBQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: Thomas Monjalon <thomas.monjalon@6wind.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 18, 2016 at 07:07:32PM +0200, Christian Ehrhardt wrote:
> Hi,
> I was debugging an issue caused by a bad usage of dpdk.
> That is fixed in the meantime and I'll backport that into our code as wel=
l.
> =

> But along debugging that, I found a potential hang in virtnet_send_comman=
d that
> my case ran into.
> The following code can become an infinite loop:
> /* Spin for a response, the kick causes an ioport write, trapping
> =A0* into the hypervisor, so the request should be handled immediately.
> =A0*/ =A0=A0
> while (!virtqueue_get_buf(vi->cvq, &tmp) && =A0=A0
> =A0 =A0 =A0 =A0!virtqueue_is_broken(vi->cvq)) =A0=A0
> =A0 =A0 =A0 =A0 cpu_relax();
> =

> In my case dpdk broke something - not exactly clear what - and due to that
> following calls through=A0virtnet_send_command ran into this hang.
> Effectively it seems that the buffers didn't get refreshed at all anymore.
> =

> That said the dpdk issue to touch devices that belong to a kernel owned d=
river
> is fixed, so one could leave the code as is for now.
> Yet I wanted to make you aware in case you would vote for a time or retry=
 based
> upper limit on that loop to avoid hangs - who knows what else might bring=
 it in
> this broken state in a different case.
> =

> Kind Regards,
> Christian Ehrhardt
> =

> P.S.
> Steps to reproduce, backtraces and more data can be found in:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1570195
> A general setup howto for DPDK in KVM guests which is a prereq is at:
> https://help.ubuntu.com/16.04/serverguide/DPDK.html#dpdk-in-guest

True. It's not that clear how to handle this cleanly though.
Ideally we'd have to transmit the next command once the
previous one completes.

-- =

MST
