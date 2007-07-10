From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Tue, 10 Jul 2007 11:53:39 +1000
Message-ID: <1184032419.6005.430.camel@localhost.localdomain>
References: <20070706124200.988637662@arndb.de>
	<200707091318.48261.arnd@arndb.de> <46921EDF.7080602@qumranet.com>
	<200707091338.20288.arnd@arndb.de>  <4692257F.4070909@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4692257F.4070909@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-07-09 at 15:09 +0300, Avi Kivity wrote:
> Arnd Bergmann wrote:
> > Why do you think we want to have multiple outstanding read messages?
> > I would guess that a single message is enough, you can always requeue
> > it after one event gets processed.
> 
> Suppose there is one message queued.  The host reconfigures and sends 
> the message. A new reconfiguration event now cannot be propagated.
> 
> If there are two messages queued, the host can post the updates in the 
> second message.  The guest would then post two new messages (since it 
> can't tell whether any reconfiguration events occured after the second 
> message), the host would fill one, and everyone is happy.

But there can always be another reconfig about to happen after whatever
the guest is processing now.  Is there any point in the guest doing
anything other than one at a time, in order?

> Rusty, If you agree with this, I think it needs to be added to the core 
> protocol.

Well, using an "events" virtqueue in the core means existing virtual I/O
mechanisms need to fake one up on the guest.  Using a function-call
interface is more natural (and doesn't stop a virtio layer from using an
events virtqueue and demuxing).

Also, are we sure about the assumption that events won't have ordering
constraints wrt other queues?  For example, a media change event might;
I don't know the semantics required there...

Rusty.
