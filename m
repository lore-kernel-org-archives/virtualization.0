From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 RFC 0/4] virtio and vhost-net capacity handling
Date: Sun, 19 Jun 2011 11:53:04 +0300
Message-ID: <20110619085304.GA9222__12055.8623726994$1308473653$gmane$org@redhat.com>
References: <cover.1307029008.git.mst@redhat.com>
	<20110607160830.GB17581@redhat.com>
	<OFE36F9C2B.43D9DB04-ON652578AE.0048E1AB-652578AE.004A1462@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <OFE36F9C2B.43D9DB04-ON652578AE.0048E1AB-652578AE.004A1462@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Krishna Kumar2 <krkumar2@in.ibm.com>
Cc: habanero@linux.vnet.ibm.com, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 13, 2011 at 07:02:27PM +0530, Krishna Kumar2 wrote:
> "Michael S. Tsirkin" <mst@redhat.com> wrote on 06/07/2011 09:38:30 PM:
> 
> > > This is on top of the patches applied by Rusty.
> > >
> > > Warning: untested. Posting now to give people chance to
> > > comment on the API.
> >
> > OK, this seems to have survived some testing so far,
> > after I dropped patch 4 and fixed build for patch 3
> > (build fixup patch sent in reply to the original).
> >
> > I'll be mostly offline until Sunday, would appreciate
> > testing reports.
> 
> Hi Michael,
> 
> I ran the latest patches with 1K I/O (guest->local host) and
> the results are (60 sec run for each test case):
> 
> ______________________________
> #sessions   BW%       SD%
> ______________________________
> 1           -25.6     47.0
> 2           -29.3     22.9
> 4              .8     1.6
> 8             1.6     0
> 16          -1.6      4.1
> 32          -5.3      2.1
> 48           11.3    -7.8
> 64          -2.8      .7
> 96          -6.2      .6
> 128         -10.6     12.7
> ______________________________
> BW: -4.8     SD: 5.4
> 
> I tested it again to see if the regression is fleeting (since
> the numbers vary quite a bit for 1K I/O even between guest->
> local host), but:
> 
> ______________________________
> #sessions  BW%     SD%
> ______________________________
> 1          14.0    -17.3
> 2          19.9    -11.1
> 4          7.9     -15.3
> 8          9.6     -13.1
> 16         1.2     -7.3
> 32        -.6      -13.5
> 48        -28.7     10.0
> 64        -5.7     -.7
> 96        -9.4     -8.1
> 128       -9.4      .7
> ______________________________
> BW: -3.7     SD: -2.0
> 
> 
> With 16K, there was an improvement in SD, but
> higher sessions seem to slightly degrade BW/SD:
> 
> ______________________________
> #sessions  BW%      SD%
> ______________________________
> 1          30.9    -25.0
> 2          16.5    -19.4
> 4         -1.3      7.9
> 8          1.4      6.2
> 16         3.9     -5.4
> 32         0        4.3
> 48        -.5        .1
> 64         32.1    -1.5
> 96        -2.1      23.2
> 128       -7.4      3.8
> ______________________________
> BW: 5.0          SD: 7.5
> 
> 
> Thanks,
> 
> - KK

I think I see one scenario where we do extra work:
when TX ring overflows, the first attempt to
add buf will fail, so the work to format the s/g
list is then wasted. So it might make sense to
free up buffers up to capacity first thing after all,
which will still do nothing typically, add buf afterwards.

-- 
MST
