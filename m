From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: rework
	VIRTIO_BALLOON_F_MUST_TELL_HOST feature, support silent deflation
Date: Tue, 28 May 2013 18:57:01 +0200
Message-ID: <51A4E1DD.9040907@redhat.com>
References: <20130528104503.GD5467@redhat.com> <51A4913F.5050206@redhat.com>
	<20130528114402.GA21107@redhat.com> <51A49D33.8090008@redhat.com>
	<20130528133256.GC4889@redhat.com> <51A4B9CA.50506@redhat.com>
	<20130528142908.GA28422@redhat.com> <51A4C00C.6020707@redhat.com>
	<20130528150956.GA28874@redhat.com> <51A4D9F7.8090504@redhat.com>
	<20130528165004.GA30296@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130528165004.GA30296@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 28/05/2013 18:50, Michael S. Tsirkin ha scritto:
>>> Both your code and what you say here about the new bit seem to break
>>> compatibility with old hosts and guests.
>>
>> What is the exact scenario that you have in mind?
> 
> Existing host follows spec, advertises MUST_TELL_HOST (only)
> guest acks that and still does not tell host.

Guest bug.  Guest should only do so if it sees SILENT_DEFLATE too.

>> Here are all the possibilities:
> 
> Basically it looks like besides TELL_HOST you want another bit
> "DONT_TELL_HOST". This just seems weird, and interactions
> between the two become very complex. Look at the amount of
> text in this thread.

Well, there are three cases, you need two bits.

The amount of text is because I'm writing the same thing 20 times in
different ways.  I'm still more satisfied with the text in the patch
than with anything I've written here.  It's possible I contradicted
myself, in fact.

>>> If it's in spec, I think it would be clearer what are we trying to
>>> achieve, and how.
>>
>> Having one or three patches doesn't change the final text...
> 
> It changes the fact that we can stop arguing about
> the thing we agree on (making TELL_HOST optional
> for guests).
> 
> We can separately argue about the one we don't seem
> to agree on (need for a new SILENT_DEFLATE).

Okay.  If you agree that your patch does entail a change for old hosts,
that would be a step forward indeed.

Paolo
