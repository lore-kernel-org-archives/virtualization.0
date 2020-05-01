From: lepton <ytht.net@gmail.com>
Subject: Re: [PATCH 0/1] Add uvirtio for testing
Date: Thu, 30 Apr 2020 17:59:05 -0700
Message-ID: <CALqoU4wfqPcOkdiWBTC4j=_U2q6gUFn5JkZsgPXr0MM4s6ZqLQ@mail.gmail.com>
References: <20200428204729.64569-1-ytht.net@gmail.com>
 <b01454e9-bca8-cf32-7cfa-ebe25032e040@redhat.com>
 <20200429115836.u5vqt3s6l4wcejjd@sirius.home.kraxel.org>
 <CALqoU4wHbkqVx2WiF4ieZ1Bg6DE5OWzzUGrQbe8EYsO8ruq3Xg@mail.gmail.com>
 <20200430075141.kjldxjhylwo347bf@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200430075141.kjldxjhylwo347bf@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 30, 2020 at 12:51 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Apr 29, 2020 at 08:59:18PM -0700, lepton wrote:
> > On Wed, Apr 29, 2020 at 4:58 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > > 3) Need to be verbose on how the vring processing work in the commit log of
> > > > patch 1
> > >
> > > Ecven better a file documenting the interface somewhere in
> > > Documentation/
> > I put a uvirtio-vga.c under samples/uvirtio and hope this can serve
> > the purpose of the document since currently that's the only tested use
> > case.
>
> Sample code is good, but *commented* sample code would be better.
>
> > Maybe have a document later if this really get more use cases?
>
> Well, having good documentation right from the start would help getting
> more use cases ;)
Now I add document in V3.

Thanks. Regards
>
> take care,
>   Gerd
>
