From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 16:32:31 +0200
Message-ID: <51A6117F.9080300@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<20130529132430.GA9363@redhat.com> <8761y1q3aw.fsf@codemonkey.ws>
	<20130529143053.GB10462@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130529143053.GB10462@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 29/05/2013 16:30, Michael S. Tsirkin ha scritto:
>> > There are other responses in the thread here and I don't really care to
>> > bikeshed on this issue.
> Great. Let's make the bikeshed blue then?

Yes, let's make it blue, but please promise to check into Peter's
register API so we can remove the case offsetof.

I checked that it works on RHEL5, which is 4.1 and probably the oldest
compiler we care about (any other 4.1 lacks the __sync builtins;
upstream added them in 4.2).

Paolo
