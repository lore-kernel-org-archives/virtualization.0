From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] virtio-blk: Add stats VQ to collect information about
	devices
Date: Thu, 18 Aug 2011 11:30:47 -0700
Message-ID: <4E4D5A57.6070600__39794.2329444506$1313692734$gmane$org@redhat.com>
References: <1313524071-27250-1-git-send-email-levinsasha928@gmail.com>
	<4E4C481A.5080205@redhat.com> <1313642283.22532.4.camel@lappy>
	<4E4D2B6D.1040908@redhat.com> <1313684984.30799.20.camel@lappy>
	<4E4D4DAC.8080304@redhat.com> <1313690353.30799.22.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1313690353.30799.22.camel@lappy>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 08/18/2011 10:59 AM, Sasha Levin wrote:
> >
> >  This is something that can be used by very few people, but everyone has
> >  to carry it.  It's more efficient to add statistics support to your
> >  automation framework (involving the guest).
> >
>
> That was just one example of many possibilities. However, if you feel
> this can't be used within monitoring or management platforms anyhow then
> I'm ok with dropping it.
>

It really depends on the possibilities.

Adding features is fine, but we need to know they'll be useful to many 
people.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
