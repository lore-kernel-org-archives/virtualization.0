From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Date: Mon, 6 Jan 2020 05:50:34 -0500
Message-ID: <20200106054041-mutt-send-email-mst__18044.017050282$1578307875$gmane$org@kernel.org>
References: <c022e1d6-0d57-ae07-5e6b-8e40d3b01f4b@de.ibm.com>
 <20191218100926-mutt-send-email-mst@kernel.org>
 <2ffdbd95-e375-a627-55a1-6990b0a0e37a@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2ffdbd95-e375-a627-55a1-6990b0a0e37a@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kvm list <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 18, 2019 at 04:59:02PM +0100, Christian Borntraeger wrote:
> On 18.12.19 16:10, Michael S. Tsirkin wrote:
> > On Wed, Dec 18, 2019 at 03:43:43PM +0100, Christian Borntraeger wrote:
> >> Michael,
> >>
> >> with 
> >> commit db7286b100b503ef80612884453bed53d74c9a16 (refs/bisect/skip-db7286b100b503ef80612884453bed53d74c9a16)
> >>     vhost: use batched version by default
> >> plus
> >> commit 6bd262d5eafcdf8cdfae491e2e748e4e434dcda6 (HEAD, refs/bisect/bad)
> >>     Revert "vhost/net: add an option to test new code"
> >> to make things compile (your next tree is not easily bisectable, can you fix that as well?).
> > 
> > I'll try.
> > 
> >>
> >> I get random crashes in my s390 KVM guests after reboot.
> >> Reverting both patches together with commit decd9b8 "vhost: use vhost_desc instead of vhost_log" to
> >> make it compile again) on top of linux-next-1218 makes the problem go away.
> >>
> >> Looks like the batched version is not yet ready for prime time. Can you drop these patches until
> >> we have fixed the issues?
> >>
> >> Christian
> >>
> > 
> > Will do, thanks for letting me know.
> 
> I have confirmed with the initial reporter (internal test team) that <driver name='qemu'/> 
> with a known to be broken linux next kernel also fixes the problem, so it is really the
> vhost changes.

OK I'm back and trying to make it more bisectable.

I pushed a new tag "batch-v2".
It's same code but with this bisect should get more information.


I suspect one of the following:

commit 1414d7ee3d10d2ec2bc4ee652d1d90ec91da1c79
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Mon Oct 7 06:11:18 2019 -0400

    vhost: batching fetches
    
    With this patch applied, new and old code perform identically.
    
    Lots of extra optimizations are now possible, e.g.
    we can fetch multiple heads with copy_from/to_user now.
    We can get rid of maintaining the log array.  Etc etc.
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

commit 50297a8480b439efc5f3f23088cb2d90b799acef
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Wed Dec 11 12:19:26 2019 -0500

    vhost: use batched version by default
    
    As testing shows no performance change, switch to that now.
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


and would like to know which.

Thanks!
