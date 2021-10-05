Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C229FC4332F
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 22:33:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA7D6120D
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 22:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BA7D6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EAA140424;
	Tue,  5 Oct 2021 22:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DfcalfY5h00k; Tue,  5 Oct 2021 22:33:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9925540406;
	Tue,  5 Oct 2021 22:33:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A0BAC0011;
	Tue,  5 Oct 2021 22:33:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0DE9C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 22:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEF6840288
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 22:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FfIiVQ-Rfea8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 22:33:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C41D400C6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 22:33:42 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 ls14-20020a17090b350e00b001a00e2251c8so800270pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NVaNuqsh2cbkaLybruNHatXvA5elgWSJDPvzOcbacUE=;
 b=EVm/hrha1IfLe4BiCQirvgf7RAapRUWd5OY2P/INgYjGkVj8hc9n6QLCp874tJH4B8
 c59PijgCMCeR1ww75e7BgxIoTbMuTYzR9/moG5aTuzHYfPG7MAW0gYXmAVqBIaYxB6u3
 pGT84S6wLaVtEx10zHX31KymEwCtGRBIM7nGxaEsjYxCLvHTfzY6xa7y7SldE/mqIVvK
 oPnKGRn3Lv3ooPEL9qBqRzUnM8cnjxO5Piw2uYrVwcD14kajcyQSUHHfM8bMcuD/Rg2L
 iTmJ3+gEulvEGrDRcURXy5eNQOactv7eOZqPRc7WNm1y+P0cIcKdewJWYVmtxJ5+4Jcu
 GLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NVaNuqsh2cbkaLybruNHatXvA5elgWSJDPvzOcbacUE=;
 b=a6ctJOFQrsAYlN5FrMSX3DoLfHHV42hp4AfNmZXYSaWa/GKNsUyHz4O2s8yEnZjx97
 +f6u+BH+yWIKLZjUgMPTSwpnkETDDVY7dFtwpi/7CRwWTBJjs7CwwwMuP89swj7iIFIG
 kY6t7R2Yr4k38WwMBZaybWLbJplXJgMutlxXpM2diX594zI/kI7iEZ5c1Iaub/4TtY2q
 j0LF4IFpXQgebax9tXTD9hMp36zyCsG1p5+invElQxp7fmHvSzGzj/TRgzFg6ynUESJ7
 jZ0VzbgEUjTYOrpYzvFBn5BU/IcA2GWt5PTTscMLZ58Jxhb4jix3gt2Z/gC3YvupaIaQ
 8vNA==
X-Gm-Message-State: AOAM530dRCYayi45Mjsf3vP91+StHxW0HBiEmop9fyAPeDiUovWvj62i
 HBRO1ICGJ9Gik1G8McZYNpd5G3zyt9kU4AQiNxlWMQ==
X-Google-Smtp-Source: ABdhPJyNUK8tRKcu+8Dd6LTnJN+R73YCyL6OGLWiFBrQ/OXrJOoHzTAHLH3By0qn+wa4u+t5oNVbKSM82eOjyEdBbGQ=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr6764886pju.8.1633473221792; 
 Tue, 05 Oct 2021 15:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <CAPcyv4gqs=KuGyxFR61QWqF6HKrRg851roCGUqrq585+s2Cm=w@mail.gmail.com>
 <20211001164533.GC505557@rowland.harvard.edu>
 <CAPcyv4i__reKFRP1KjWUov_W5jBQN9_vbUbKRL_V7KMM3oPuuQ@mail.gmail.com>
 <20211001190048.GA512418@rowland.harvard.edu>
 <CAPcyv4hYL51DcBuSuyMRFo5Jcc=zLd=Ugo+H_2saELcZ5AJBeQ@mail.gmail.com>
 <YVqONA0vhl0/H3QE@lahna>
In-Reply-To: <YVqONA0vhl0/H3QE@lahna>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 5 Oct 2021 15:33:29 -0700
Message-ID: <CAPcyv4im4Tsj1SnxSWe=cAHBP1mQ=zgO-D81n2BpD+_HkpitbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "Kuppuswamy,
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux PCI <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 USB list <linux-usb@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Oct 3, 2021 at 10:16 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Fri, Oct 01, 2021 at 12:57:18PM -0700, Dan Williams wrote:
> > > > Ah, so are you saying that it would be sufficient for USB if the
> > > > generic authorized implementation did something like:
> > > >
> > > > dev->authorized = 1;
> > > > device_attach(dev);
> > > >
> > > > ...for the authorize case, and:
> > > >
> > > > dev->authorize = 0;
> > > > device_release_driver(dev);
> > > >
> > > > ...for the deauthorize case?
> > >
> > > Yes, I think so.  But I haven't tried making this change to test and
> > > see what really happens.
> >
> > Sounds like a useful path for this effort to explore. Especially as
> > Greg seems to want the proposed "has_probe_authorization" flag in the
> > bus_type to disappear and make this all generic. It just seems that
> > Thunderbolt would need deeper surgery to move what it does in the
> > authorization toggle path into the probe and remove paths.
> >
> > Mika, do you see a path for Thunderbolt to align its authorization
> > paths behind bus ->probe() ->remove() events similar to what USB might
> > be able to support for a generic authorization path?
>
> In Thunderbolt "authorization" actually means whether there is a PCIe
> tunnel to the device or not. There is no driver bind/unbind happening
> when authorization toggles (well on Thunderbolt bus, there can be on PCI
> bus after the tunnel is established) so I'm not entirely sure how we
> could use the bus ->probe() or ->remove for that to be honest.

Greg, per your comment:

"... which was to move the way that busses are allowed to authorize
the devices they wish to control into a generic way instead of being
bus-specific logic."

We have USB and TB that have already diverged on the ABI here. The USB
behavior is more in line with the "probe authorization" concept, while
TB is about tunnel establishment and not cleanly tied to probe
authorization. So while I see a path to a common authorization
implementation for USB and other buses (per the insight from Alan), TB
needs to retain the ability to record the authorization state as an
enum rather than a bool, and emit a uevent on authorization status
change.

So how about something like the following that moves the attribute
into the core, but still calls back to TB and USB to perform their
legacy authorization work. This new authorized attribute only shows up
when devices default to not authorized, i.e. when userspace owns the
allow list past critical-boot built-in drivers, or if the bus (USB /
TB) implements ->authorize().


diff --git a/drivers/base/core.c b/drivers/base/core.c
index e65dd803a453..8f8fbe2637d1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2414,6 +2414,58 @@ static ssize_t online_store(struct device *dev,
struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(online);

+static ssize_t authorized_show(struct device *dev,
+                              struct device_attribute *attr, char *buf)
+{
+       return sysfs_emit(buf, "%u\n", dev->authorized);
+}
+
+static ssize_t authorized_store(struct device *dev,
+                               struct device_attribute *attr, const char *buf,
+                               size_t count)
+{
+       unsigned int val, save;
+       ssize_t rc;
+
+       rc = kstrtouint(buf, 0, &val);
+       if (rc < 0)
+               return rc;
+
+       /* some buses (Thunderbolt) support authorized values > 1 */
+       if (val > 1 && !dev->bus->authorize)
+               return -EINVAL;
+
+       device_lock(dev);
+       save = dev->authorized;
+       if (save == val) {
+               rc = count;
+               goto err;
+       }
+
+       dev->authorized = val;
+       if (dev->bus->authorize) {
+               /* notify bus about change in authorization state */
+               rc = dev->bus->authorize(dev);
+               if (rc) {
+                       dev->authorized = save;
+                       goto err;
+               }
+       }
+       device_unlock(dev);
+
+       if (dev->authorized) {
+               if (!device_attach(dev))
+                       dev_dbg(dev, "failed to probe after authorize\n");
+       } else
+               device_release_driver(dev);
+       return count;
+
+err:
+       device_unlock(dev);
+       return rc < 0 ? rc : count;
+}
+static DEVICE_ATTR_RW(authorized);
+
 static ssize_t removable_show(struct device *dev, struct
device_attribute *attr,
                              char *buf)
 {
@@ -2616,8 +2668,16 @@ static int device_add_attrs(struct device *dev)
                        goto err_remove_dev_waiting_for_supplier;
        }

+       if (dev_needs_authorization(dev)) {
+               error = device_create_file(dev, &dev_attr_authorized);
+               if (error)
+                       goto err_remove_dev_removable;
+       }
+
        return 0;

+ err_remove_dev_removable:
+       device_remove_file(dev, &dev_attr_removable);
  err_remove_dev_waiting_for_supplier:
        device_remove_file(dev, &dev_attr_waiting_for_supplier);
  err_remove_dev_online:
@@ -2639,6 +2699,7 @@ static void device_remove_attrs(struct device *dev)
        struct class *class = dev->class;
        const struct device_type *type = dev->type;

+       device_remove_file(dev, &dev_attr_authorized);
        device_remove_file(dev, &dev_attr_removable);
        device_remove_file(dev, &dev_attr_waiting_for_supplier);
        device_remove_file(dev, &dev_attr_online);
@@ -2805,6 +2866,8 @@ static void klist_children_put(struct klist_node *n)
        put_device(dev);
 }

+unsigned int dev_default_authorization;
+
 /**
  * device_initialize - init device structure.
  * @dev: device.
diff --git a/include/linux/device.h b/include/linux/device.h
index e270cb740b9e..fbb83e46af9d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -561,6 +561,7 @@ struct device {
        struct dev_iommu        *iommu;

        enum device_removable   removable;
+       unsigned int            authorized;

        bool                    offline_disabled:1;
        bool                    offline:1;
@@ -814,6 +815,19 @@ static inline bool dev_removable_is_valid(struct
device *dev)
        return dev->removable != DEVICE_REMOVABLE_NOT_SUPPORTED;
 }

+extern unsigned int dev_default_authorization;
+
+/*
+ * If the bus has custom authorization, or if devices default to not
+ * authorized, register the 'authorized' attribute for @dev.
+ */
+static inline bool dev_needs_authorization(struct device *dev)
+{
+       if (dev->bus->authorize || dev_default_authorization == 0)
+               return true;
+       return false;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 062777a45a74..3202a2b13374 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -40,6 +40,11 @@ struct fwnode_handle;
  *             that generate uevents to add the environment variables.
  * @probe:     Called when a new device or driver add to this bus, and callback
  *             the specific driver's probe to initial the matched device.
+ * @authorize: Called after authorized_store() changes the
+ *             authorization state of the device. Do not use for new
+ *             bus implementations, revalidate dev->authorized in
+ *             @probe and @remove to take any bus specific
+ *             authorization actions.
  * @sync_state:        Called to sync device state to software state
after all the
  *             state tracking consumers linked to this device (present at
  *             the time of late_initcall) have successfully bound to a
@@ -90,6 +95,7 @@ struct bus_type {
        int (*match)(struct device *dev, struct device_driver *drv);
        int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
        int (*probe)(struct device *dev);
+       int (*authorize)(struct device *dev);
        void (*sync_state)(struct device *dev);
        void (*remove)(struct device *dev);
        void (*shutdown)(struct device *dev);
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
