From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Wed, 21 Feb 2018 18:02:13 -0800
Message-ID: <20180221180213.30885283@cakuba.netronome.com>
References: <20180220162933.GD2031@nanopsycho>
	<509bbbf9-4db7-dc78-a05e-403452a7407a@intel.com>
	<20180220201410.GF2031@nanopsycho>
	<20180220143356.3467084d@cakuba.netronome.com>
	<20180221095159.GA1996@nanopsycho>
	<CAKgT0UdyhrVr=pYZb=AJq9sWWUVb_BadbJTcqY1AwHHTw8cmQw@mail.gmail.com>
	<20180221161105.GC1996@nanopsycho>
	<CAKgT0Ud+6eiY7ycyju1SToeatH1R7KBDcUOqjn9Pu2k5uOr5Wg@mail.gmail.com>
	<20180221165848.GD1996@nanopsycho>
	<CAKgT0UeZS_SzNfiMX3ujy+a9WZWySVdyTpyQ=b=RJJrAG3JO=w@mail.gmail.com>
	<20180221193832.GE1996@nanopsycho>
	<CAKgT0Ud--R7Mw1_jFckskhGmGLZgZbTZ24TuvJ+UWvm_MAQR9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAKgT0Ud--R7Mw1_jFckskhGmGLZgZbTZ24TuvJ+UWvm_MAQR9w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 21 Feb 2018 12:57:09 -0800, Alexander Duyck wrote:
> > I don't see why the team cannot be there always.  
> 
> It is more the logistical nightmare. Part of the goal here was to work
> with the cloud base images that are out there such as
> https://alt.fedoraproject.org/cloud/. With just the kernel changes the
> overhead for this stays fairly small and would be pulled in as just a
> standard part of the kernel update process. The virtio bypass only
> pops up if the backup bit is present. With the team solution it
> requires that the base image use the team driver on virtio_net when it
> sees one. I doubt the OSVs would want to do that just because SR-IOV
> isn't that popular of a case.

IIUC we need to monitor for a "backup hint", spawn the master, rename it
to maintain backwards compatibility with no-VF setups and enslave the VF
if it appears.

All those sound possible from user space, the advantage of the kernel
solution right now is that it has more complete code.

Am I misunderstanding?
