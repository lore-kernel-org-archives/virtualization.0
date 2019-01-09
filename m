From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: __get_user slower than get_user (was Re: [RFC PATCH V3 0/5] Hi:)
Date: Tue, 8 Jan 2019 21:19:52 -0800
Message-ID: <CAHk-=wjDQCttbTZjEC8DbZdq8=eTpS2e-9jQQD+WdutFArzHwQ__29854.7024060555$1547011203$gmane$org@mail.gmail.com>
References: <20190102154038-mutt-send-email-mst@kernel.org>
	<0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com>
	<20190106221832-mutt-send-email-mst@kernel.org>
	<c15a17b3-b604-a105-af44-a7e6dfd79801@redhat.com>
	<20190106230224-mutt-send-email-mst@kernel.org>
	<CAPcyv4iXFy0jfoQ_jQYq2yA7cqu4_Jcap4mvQesRRrV-hahGvQ@mail.gmail.com>
	<20190107084853-mutt-send-email-mst@kernel.org>
	<CAPcyv4jf-4=2oGJrdvMBeRiAJnQoKbYhwZDD+5ZEH+xgDaOzRQ@mail.gmail.com>
	<20190107172517-mutt-send-email-mst@kernel.org>
	<CAPcyv4iQMQxZC8ehr2OP8_rqpuCeSWn5xyKN64JSyfR8_r7eOg@mail.gmail.com>
	<20190108232459-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190108232459-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 8, 2019 at 8:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Linus, given that you just changed all users of access_ok anyway, do
> you still think that the access_ok() conversion to return a speculation
> sanitized pointer or NULL is too big a conversion?

I didn't actually change a single access_ok().

I changed the (very few) users of "user_access_begin()" to do an
access_ok() in them. There were 8 of them total.

It turns out that two of those cases (the strn*_user() ones) found
bugs in the implementation of access_ok() of two architectures, and
then looking at the others found that six more architectures also had
problems, but those weren't actually because of any access_ok()
changes, they were pre-existing issues. So we definitely had
unfortunate bugs in access_ok(), but they were mostly the benign kind
(ir the "use arguments twice - a real potential bug, but not one that
actually likely makes any difference to existing users)

Changing all 600+ users of access_ok() would be painful.

That said, one thing I *would* like to do is to just get rid of
__get_user() and __put_user() entirely. Or rather, just make them do
exactly the same thing that the normal "get_user()"/"put_user()"
functions do.

And then, _within_ the case of get_user()/put_user(), doing the
access_ok() as a data dependency rather than a lfence should be easy
enough.

                     Linus
