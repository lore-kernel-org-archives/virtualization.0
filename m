From: nitesh narayan lal <niteshnarayanlalleo@gmail.com>
Subject: Re: virtio performance analysis
Date: Tue, 14 May 2013 11:37:00 +0530
Message-ID: <CAAtA1-ZAMfzyuC_XdABXWdEB0-HDqidWEFteWv+s-bm_eDmtQw@mail.gmail.com>
References: <CAAtA1-aB_EQruG8ta=xjt8LO-522_5=YbKCL_33exXG2n5vutw@mail.gmail.com>
	<20130506101936.GA16906@redhat.com>
	<CAAtA1-ZTU7oance7f4=eHGqAf-g+u5e+JwPHMp3iAusHgBphLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAAtA1-ZTU7oance7f4=eHGqAf-g+u5e+JwPHMp3iAusHgBphLQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,
I had seen the virtqueue_kick_prepare() where vring_need_event() is
been used, but somehow for every start_xmit() call vq->event and
need_kick is been set to true.
Due to which for every start_xmit() its kicking via notify() routine.
Regards
Nitesh Narayan Lal
